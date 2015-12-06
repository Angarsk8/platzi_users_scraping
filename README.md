##Platzi Users Scraping

###Usage

To use this script be sure you have installed the required gems (you can see them in the Gemfile). I have already configured a bundle so check if you have the ***bundler*** gem installed, if not, execute `gem install bundler` in a terminal shell and then execute `bundle install`(this will install all the required gems to run the run.rb script).

Once you have installed all the gems, execute the script with the following command:

```
ruby run.rb
```

The above commad will scrape the data from some Platzi users profiles (The ones that are in the USERS_PATHS constant in the users.rb file) and retrieves the relevant data as a JSON and CSV(see below for more information).

###Sample Outputs 

* ***users.json***:

```javascript
[
  {
    "source": "Platzi",
    "name": "Ale Polendo",
    "username": "AlePolend",
    "country": "United States",
    "twitter": "",
    "facebook": "http://facebook.com/1235427096472738",
    "website": ""
  },
  {
    "source": "Platzi",
    "name": "Lucia",
    "username": "Luu_B",
    "country": "Argentina",
    "twitter": "http://twitter.com/intent/user?user_id=866844176",
    "facebook": "",
    "website": ""
  },
  {
    "source": "Platzi",
    "name": "Alex Manosalva Q",
    "username": "alexmanosalva",
    "country": "Colombia",
    "twitter": "",
    "facebook": "http://facebook.com/1104010416295147",
    "website": ""
  },
  ...
]
```

* ***users.csv***:
```
source; name; username; country; twitter; facebook; website
Platzi; "Ale Polendo"; AlePolend; "United States"; ""; http://facebook.com/1235427096472738; ""
Platzi; Lucia; Luu_B; Argentina; http://twitter.com/intent/user?user_id=866844176; ""; ""
Platzi; "Alex Manosalva Q"; alexmanosalva; Colombia; ""; http://facebook.com/1104010416295147; ""
Platzi; "Chris Miller"; chrismilleres; Espana; http://twitter.com/intent/user?user_id=85773713; ""; ""
Platzi; "Rafa MarRo"; darkoinfernor; Mexico; ""; http://facebook.com/100005026964633; ""
Platzi; Felipe; felipemarcelocaroc; Chile; ""; http://facebook.com/10206954521600167; ""
Platzi; t.wittero; illuminati74; Espana; http://twitter.com/intent/user?user_id=1660430599; ""; ""
Platzi; JöHny; johnyalejandr; Colombia; ""; http://facebook.com/897045003678651; ""
Platzi; "Eduardo Lemus"; lemussi; Mexico; http://twitter.com/intent/user?user_id=210660975; ""; ""
...
```
