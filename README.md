Mobile Fu
=========

Want to automatically detect mobile devices that access your Rails application?
Mobile Fu allows you to do just that.  People can access your site from a Palm,
Blackberry, iPhone, iPad, Nokia, etc. and it will automatically adjust the format
of the request from :html to :mobile or :tablet.

Installation
------------

Simply add `gem 'mobile-fu'` to your Gemfile and run bundle install.

Usage
-----

Add this this one line to the controller.

```ruby
class ApplicationController < ActionController::Base
  has_mobile_fu
end
```

Once this is in place, any request that comes from a mobile device will be be
set as :mobile format.  It is up to you to determine how you want to handle
these requests.  It is also up to you to create the .mobile.erb versions of
your views that are to be requested.

If you do not want to set the format to :mobile or :tablet and only use the
helper functions, pass false as an argument.

```ruby
class ApplicationController < ActionController::Base
  has_mobile_fu false
end
```

If you dont want to have all the methods respond to :mobile and :tablet, you can opt-in this actions
using the following class method: `has_mobile_fu_for :action`
Example:

```ruby
class YourAwesomeClass < ActionController::Base
  has_mobile_fu
  has_mobile_fu_for :index

  def index
    # Mobile format will be set as normal here if user is on a mobile device
  end

  def another_method
    # Mobile format will not be set, even if user is on a mobile device
  end
```

Mobile Fu automatically adds a new `:mobile` and `:tablet` to `text/html` mime type
alias for Rails apps. If you already have a custom `:mobile` alias registered in
`config/initializers/mime_types.rb`, you can remove that.

I recommend that you setup a before_filter that will redirect to a specific page
depending on whether or not it is a mobile request.  How can you check this?

```ruby
is_mobile_device? # => Returns true or false depending on the device or

is_tablet_device? # => Returns true if the device is a tablet
```

You can also determine which format is currently set in by calling the following:

```ruby
in_mobile_view? # => Returns true or false depending on current req. format or

in_tablet_view? # => Returns true if the current req. format is for tablet view
```

Also, if you want the ability to allow a user to switch between 'mobile' and
'standard' format (:html), you can just adjust the mobile_view session variable
in a custom controller action.

```ruby
session[:mobile_view] # => Set to true if request format is :mobile and false
                           if set to :html

session[:tablet_view] # => Set to true if request format is :tablet and false
                           if set to :html
```

If you want to use the default response templates, like index.html.erb, instead of the index.tablet.erb you can
exclude the tablet rendering from beeing used:
you can create a `before_filter` and put it before the has_mobile_fu call

```ruby
before_filter :force_tablet_html
has_mobile_fu

def force_tablet_html
	session[:tablet_view] = false
end
```

Same will work for mobile, just change the `tablet` values to `mobile`

So, different devices need different styling.  Don't worry, we've got this
baked in to Mobile Fu.

If you are including a css or sass file via `stylesheet_link_tag`, all you have
to do is add _device to the name of one of your files to override your styling
for a certain device.  The stylesheet that is loaded is dependant on which device
is making the request.

e.g., Accessing a page from a Blackberry.

```ruby
stylesheet_link_tag 'mobile.css'
```

This loads mobile.css, and mobile_blackberry.css if the file exists.

Supported stylesheet override device extensions at the moment are:

  * blackberry
  * iphone (iphone,ipod)
  * ipad
  * android
  * mobileexplorer
  * nokia
  * palm

The stylesheet awesomeness was derived from [Michael Bleigh's browserized styles](http://www.intridea.com/2007/12/9/announcing-browserized-styles)

Inspiration for Mobile Fu came from [Noel Rappin's rails_iui](http://blogs.pathf.com/agileajax/2008/05/rails-developme.html)

Hopefully this should help you create some awesome mobile applications.

Testing Mobile Interface
------------------------

If you want to force the mobile interface for testing, you can either use a
mobile device emulator, or you can call `force_mobile_format` in a before filter.

```ruby
class ApplicationController < ActionController::Base
  has_mobile_fu
  before_filter :force_mobile_format
end
```

You can also force the tablet view by calling `force_tablet_format` instead

```ruby
class ApplicationController < ActionController::Base
  has_mobile_fu
  before_filter :force_tablet_format
end
```

Copyright (c) 2008 Brendan G. Lim, Intridea, Inc., released under the MIT license
