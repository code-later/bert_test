# BERT-RPC Example (aka Pony-Service)

To demonstrate how the application of BERT-RPC within Ruby could look
like I build an API which returns JSON based on remote service calls.

There are two parts in this example:

 * PonyAPI
 * PonyService

The PonyAPI is the user facing interface wich provides a HTTP-based
access and returns JSON encoded data.

The PonyService is an external handler to be used with Ernie. It queries
some external resource (i.e. the Wikipedia) and returns some data from
that resource. This is done to actually do something and not only return
a string.

## Setup

To get the example running you need to install Erlang. This is required
for the Ernie server. Any version above R13B should work. I recommend
installing it via homebrew (`homebrew install erlang`). **Note:** This
will take some time ;-)

After that you need to run a `bundle install` in the two projects
`pony_api` and `pony_service`. Assuming all dependencies got installed
you can start the API with `bundle exec rackup`. The Ernie server is
started with `bundle exec ernie -c service.cfg -d` (to stop it run
`bundle exec ernie halt`).

To test this setup just call the API with curl:

    $ curl http://localhost:9292/ponies/Applejack

The result should look like this:

    {
      "name": "Applejack",
      "description": "Applejack is an earth pony
        with an orange body and blonde mane and tail. Originally, she was
        featured in the 1984 TV special, and has almost the same appearance
        with the Generation 1 counterpart, but speaks with a Southern
        American accent and having fewer apples on her cutie mark.[2]
        Applejack is very dependable and down-to-earth, but also tends to
        act stubborn. She wears a brown cowboy hat and is the only one of
        the six main characters who keeps her mane and tail tied back,
        instead of letting them fall loose. Applejack comes from a large
        family of ponies with apple-related names, spread all over
        Equestria, who oversee apple orchards and run a group of businesses
        to sell apples and products made from them.[1] She works in her farm
        Sweet Apple Acres, where she lives with her younger sister Apple
        Bloom, older brother Big Macintosh and Granny Smith. Applejack has
        demonstrated her strength and dexterity on many occasions, and she
        is also very skilled with a lasso. She represents the element of
        honesty. She has a pet Border Collie named Winona."
    }

## What happened?

In short here is what happened:

 * The `curl` request hit a Sinatra app which handles the JSON encoding
 * The Sinatra app will call the `PonyService` via `BERT-RPC`
 * The request to the service implementation is handled by Ernie
 * The request is passed to the Ruby implementation
 * The service implementation will reach out to Wikipedia, get
   information about the requested pony and will pass it back as a Ruby
   hash
 * The Ruby hash is serialized, transferred back to the API and there
   deserialized
 * The API will encode it as JSON and respond with the JSON payload to
   the `curl` request

_Have Fun ;-)_
