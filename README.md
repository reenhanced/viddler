README
======

The aim of this is to provide a more complete Ruby wrapper to Viddler's API, 
with an optional ActiveRecord style interface.

Calling Methods
---------------
Methods will be able to be called directly and will return plain hashes, like
the following:

    viddler = Riddler::Client.new(api_key, username, password)
    video = viddler.videos.getDetails(:video_id => "a2gf34")
    puts video['title'] # => "My Video"
    
Using Objects
-------------
You'll also be able to use ActiveRecord like objects:

    video = Riddler::Video.find('a2gf34')
    puts video.title # => "My Video"
    
    video.title = "My New Title"
    video.save!
    puts video.title # => "My New Title"
    
I'm not sure yet how exactly sessions/authentication will work with this model,
maybe something like this:

    Riddler::Base.api_key = "1234"
    Riddler::Session.new('kyleslat', 'password') do
      video = Riddler::Video.find('a2gf34')
    end
    
That might be a bit too much, though, so it could also be something like this:

    Riddler::Base.api_key = "1234"
    @session = Riddler::Session.new('kyleslat', 'password')
    
    video = Riddler::Video.find('a2gf34', @session)
    
I'm thinking the 2nd method probably makes the most sense to go with.  The
`video` object would retain the `@session` so that in can make any future calls
with it.

Uploading
---------
Uploading would be abstracted by the `Riddler::Video` object:

    video = Riddler::Video.new
    video.source = File.open('myvideo.mpg')
    video.title  = "awesome video!"
    
    video.save! # uploads video, sets title
    
    video.source = File.open('myvideo2.mpg')  # raises error, since video
                                              # source is already set and can't
                                              # be changed