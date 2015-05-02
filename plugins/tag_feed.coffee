module.exports = (env, callback) ->
        class TagFeed extends env.ContentPlugin
                constructor: (@tagName, @articles) ->
                        
                getFilename: ->
                        'tag/' + @tagName + '/feed.xml'
                        
                getView: -> (env, locals, contents, templates, callback) ->
                        template = templates['tag_feed.html']
                        # setup the template context
                        # ctx = {@articles, @tagName}
                        ctx = {@articles, @tagName}
                        # extend the template context with the enviroment locals
                        env.utils.extend ctx, locals
                        # finally render the template
                        template.render ctx, callback
                
        # register a generator, 'paginator' here is the content group generated content will belong to
        # i.e. contents._.paginator
        env.registerGenerator 'tagPaginator', (contents, callback) ->
                tags = env.helpers.getAllTags()
                rv = {tag_feeds:{}}
                
                tags.forEach (tag) ->
                        articles = env.helpers.getArticlesByTag contents, tag
                        console.log tag
                        tag_feed = new TagFeed tag, articles
                        rv.tag_feeds["#{tag}.page"] = tag_feed
                        
                # callback with the generated contents
                callback null, rv

        callback()
