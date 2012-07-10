class Jekyll::BlogGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    argument :name, :type => :string, :default => "blog"

    def copy_config_file
        copy_file 'blog/jekyll/_config.yml.tt', 'blog/jekyll/_config.yml'
        copy_file 'blog/jekyll/atom.xml.tt', 'blog/jekyll/atom.xml'
        copy_file 'blog/jekyll/index.html.tt', 'blog/jekyll/index.html'
        copy_file 'blog/jekyll/_layouts/default.html.tt', 'blog/jekyll/_layouts/default.html'
        copy_file 'blog/jekyll/_layouts/page.html.tt', 'blog/jekyll/_layouts/page.html'
        copy_file 'blog/jekyll/_layouts/post.html.tt', 'blog/jekyll/_layouts/post.html'
        copy_file 'blog/jekyll/_posts/2012-04-25-a-test-post.markdown.tt', 'blog/jekyll/_posts/2012-04-25-a-test-post.markdown'
        copy_file 'blog/jekyll/css/screen.css.tt', 'blog/jekyll/css/screen.css'
        copy_file 'blog/jekyll/css/syntax.css.tt', 'blog/jekyll/css/syntax.css'
        copy_file 'tasks/new_post.rake.tt', 'lib/tasks/new_post.rake'
        copy_file 'tasks/gen.rake.tt', 'lib/tasks/gen.rake'
    end

    def create_blog source = 'blog/jekyll', destination = 'public/blog'
        options = {
            'source' => source,
            'destination' => destination
        }
        source_dir = 'blog/jekyll'
        options = Jekyll.configuration(options)
        site = Jekyll::Site.new(options)
        
        begin
          site.process
        rescue Jekyll::FatalException => e
          puts
          puts "ERROR: YOUR SITE COULD NOT BE BUILT:"
          puts "------------------------------------"
          puts e.message
          exit(1)
        end
        puts "Successfully generated site: #{source} -> #{destination}"
    end
end
