var profilePaths = JSON.stringify(
    Array.prototype.slice
    .apply(document.querySelectorAll(".author"))
    .map(function(el, i) {
        return el.href
    })
    .sort()
    .filter(function(value, index, array) {
        return (index === 0) || (value !== array[index - 1]);
    })
).replace(/(\r\n|\n|\r|\[|\])/gm, "");
