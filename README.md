# KyotoCabinet Persistence Adapter #

http://rubygems.org/gems/persistence-adapter-kyotocabinet

# Summary #

Adapter to use KyotoCabinet as storage port for Persistence.

# Description #

Implements necessary methods to run Persistence on top of Kyoto Cabinet.

# Install #

* sudo gem install persistence-adapter-kyotocabinet

# Usage #

The KyotoCabinet adapter is an abstract implementation. Using it requires specifying serialization methods. This permits the creation of concrete adapter implementations that are highly configurable.

At this point, two versions exist:

* KyotoCabinet::Marshal
* KyotoCabinet::YAML

```ruby
kyotocabinet_adapter = ::Persistence::Adapter::KyotoCabinet::Marshal.new
Persistence.enable_port( :kyotocabinet_marshal_port, kyotocabinet_adapter )
```

# License #

  (The MIT License)

  Copyright (c) 2012, Asher, Ridiculous Power

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
