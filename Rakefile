task default: [:build]

desc "Build the website"
task :build do
  system "rm -rf _build/* && bundle exec flutterby build"
end

desc "Deploy the website"
task deploy: [:build] do
  system "rsync -vr --del _build/* sunder:/var/www/hmans.io/"
end
