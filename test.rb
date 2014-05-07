#/usr/bin/ruby

require 'aptly'

Aptly.create_mirror(
  "ubuntu",
  "http://us.archive.ubuntu.com/ubuntu",
  "precise",
  components: ["main"],
  archlist: ["amd64", "i386"]
)
#p Aptly::mirror_info "oneiric"
#mirror = Aptly::Mirror.new "oneiric"
#mirror = Aptly::create_mirror "puppetlabs-deps", "http://apt.puppetlabs.com", dist: 'precise'
#mirror = Aptly::Mirror.new "puppetlabs-deps"
#mirror.update
#Aptly::update_mirrors
#repo = Aptly.create_repo "test2", comment: "Cool repo, bro"
#repo = Aptly::Repo.new "test2"
#repo.comment = "some other comment, dude!"
#repo.save
#repo.add "/Users/ryanuber/Downloads/"
#repo.drop
