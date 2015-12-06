require 'ruby-progressbar'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'
require('./users')

include Users

def build_users_information (doc, url)
    source = "Platzi"
    name = doc.at_css(".ProfilePersonal-name").text.strip
    username = url.sub("https://platzi.com/usuarios/", "").chop
    country = doc.at_css(".ProfilePersonal-country").text.strip

    # safe validation for twitter
    _twitter = doc.at_css(".ProfilePersonal-socialInfo").at_css(".icon-twt")
    twitter = _twitter ? _twitter.at_css("a").attribute("href").value.sub("//", "http://").strip : ""

    # safe validation for facebook
    _facebook = doc.at_css(".ProfilePersonal-socialInfo").at_css(".icon-fcbk")
    facebook = _facebook ? _facebook.at_css("a").attribute("href").value.sub("//", "http://").strip : ""

    # safe validation for website
    _website = doc.at_css(".ProfilePersonal-url")
    website = _website ? _website.at_css("a").attribute("href").value.strip : ""

    {
        source: source,
        name: name,
        username: username,
        country: country,
        twitter: twitter,
        facebook: facebook,
        website: website
    }
end

def fetch_data_from_url(base_url, users_paths)
    bar = ProgressBar.create(
        :format => '%a |%b>>%i| %P%% %t',
        :total => users_paths.length
    )
    return JSON.pretty_generate(
        users_paths.map do |path|
            begin
                composed_url = "#{base_url}#{path}"
                html = open(composed_url)
                doc = Nokogiri::HTML(html)
                bar.log "Fetching data from #{composed_url}"
                bar.increment
                build_users_information(doc, composed_url)
            rescue Exception => e
                bar.log "URL redirection problem: #{e.message}"
            end
        end.compact
    )
end

def write_text_to_file (file_name, mode = "w", data)
    output_file = File.new(file_name, mode)
    output_file.puts data
    output_file.close
end

def build_users_csv(file_name, mode = "w", users)
    CSV.open(file_name, mode, {:col_sep => "; "}) do |csv|
        csv << [
            "source", "name","username",
            "country", "twitter", "facebook",
            "website"
        ]
        JSON.parse(users).each do |user|
            csv << [
                user["source"], user["name"], user["username"],
                user["country"], user["twitter"], user["facebook"],
                user["website"]
            ]
        end
    end
end

def build_data_for_users(dir_name, file_name, base_url, users_paths)
    users = fetch_data_from_url(base_url, users_paths)
    write_text_to_file("#{dir_name}/#{file_name}.json", "w", users)
    build_users_csv("#{dir_name}/#{file_name}.csv", "w", users)
end

def create_output_folder(dir_name)
    Dir.mkdir(dir_name) unless Dir.exist? dir_name
end

def main
    begin
        output_dir = "output"
        base_url = BASE_URL
        users_paths = USERS_PATHS
        create_output_folder(output_dir)
        build_data_for_users(output_dir,"users", base_url, users_paths)
        puts "The process has finished succesfully"
    rescue Exception => e
        puts "An error has ocurred: #{e}"
    end
end

main
