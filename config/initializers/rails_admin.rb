# RailsAdmin config file. Generated on September 15, 2013 18:15
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Tech Savvy Jobs', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_admin } # auto-generated

  # Enable authorization in models
  config.authorize_with :cancan

  # Customize items per page
  config.default_items_per_page = 18

  # If you want to track changes on your models:
  # config.audit_with :history, 'Admin'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'Admin'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Admin', 'Feed']

  # Include specific models (exclude the others):
  # config.included_models = ['Admin', 'Feed']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:



  ###  Admin  ###

  # config.model 'Admin' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your admin.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Feed  ###

  config.model 'Feed' do
    list do
      sort_by :id
      configure :id do
        sort_reverse false
      end
      configure :fetch do
        hide
      end
      configure :list do
        hide
      end
    end

    edit do
      configure :total do
        hide
      end
    end
  end


  config.model 'Lead' do
    list do
      sort_by :date
      configure :date do
        strftime_format "%a %d %b %H:%M"
      end
      configure :id do
        hide
      end
      configure :digest do
        hide
      end
    end

    edit do
      configure :digest do
        hide
      end
    end
  end


  #   # Found columns:

  #     configure :id, :integer
  #     configure :approved, :boolean
  #     configure :link, :string
  #     configure :name, :string
  #     configure :split_reg, :string
  #     configure :is_rss, :boolean
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
