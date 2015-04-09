source "https://supermarket.chef.io"

def opsworks_cookbook(name, branch='release-chef-11.10')
  cookbook name, github: 'aws/opsworks-cookbooks', branch: branch, rel: name
end

opsworks_cookbooks = Dir['opsworks-cookbooks' + '/*'].select { |f| File.directory?(f)  }.map { |f| File.basename(f)  }

opsworks_cookbooks.each do |cb|
  cookbook(cb, path: File.join('/Users/jt/nclouds/demo_ops/opsworks-cookbooks', cb))
end
cookbook "opsworks_agent", path: "cookbooks/opsworks_agent"
