require 'thor'

require 'copy_kit'

module Copykit

  class RiverPermissions < Thor

    desc "convert", "Convert River Permsisions node prototype to Rails"

    method_option :input, :aliases => '-i',
                  default: '../river-permissions-prototype/app/views/version_3/', :desc => "Path to the  node Views"

    method_option :output, :aliases => '-o',
                  default: 'tmp/copy_kit/output', :desc => "Path to create new River Permissions Rails Views"

    def convert

      CopyKit::Configuration.configure do |c|

        c.module_name = "FloodRiskEngine"
        c.verbose = true
        c.main_flow_model = 'enrollment'

        c.form_id = 'f'
        c.remove_html_tags = ['main']
        c.remove_form = true

        c.form_template = :reform_style_template
        c.remove_back_links = true
        c.remove_button_links = true
        c.remove_submit = true
        c.reform_template = :step_reform_form

        c.page_title_method = "page_title"

        c.views_as_partials = true

        c.generate_views = true
        c.generate_localization  = true
        c.generate_reform = true
      end

      CopyKit::Configuration.setup_from_hash(options)

      files = if(File.directory?(options[:input]))
                glob = File.join(options[:input], '**', '*.html')
                puts "Searching for .html files in [#{glob}]"
                Dir[glob]
              else
                [options[:input]]
              end

      files.each do |f|
        next if(File.directory?(f))

        result = File.join(options[:output], "#{File.basename(f)}")
        CopyKit::NodeViewToRails.new.convert_view(f, result)
      end
    end

  end # class

end # module
