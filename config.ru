require "bundler"
Bundler.require
require "flutterby/server"

root = Flutterby::Node.new("/", fs_path: "./site/")
root.stage!

server = Flutterby::Server.new(root)

use Rack::CommonLogger
use BetterErrors::Middleware
run server
