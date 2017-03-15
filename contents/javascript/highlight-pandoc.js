$(document).ready(function() {
    $("pre code")
        .each(function(i, block){
            $(block).html(function(index, html) {
                var clazz = $(this).parent().attr("class");
                if (clazz) {
                    var possibleLangs = clazz.split(" ");
                    for (var i = 0; i < possibleLangs.length; i++) {
                        var lang = possibleLangs[i];
                        if (lang && lang != "sourceCode") {
                            try {
                                return hljs.highlight(lang, $(this).text(), true).value;
                            } catch (e) {
                                // Skip error and try the next possible lang name
                                console.log(e)
                            }
                        }
                    }
                }
                return html;
            });
        });
});
