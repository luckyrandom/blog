$(document).ready(function() {
    $("pre code")
        .each(function(i, block){
            $(block).html(function(index, html) {
                var lang = $(this).parent().attr("class");
                if (lang)
                    return hljs.highlight(lang, $(this).text(), true).value;
                else
                    return html;
            });
        });
});
