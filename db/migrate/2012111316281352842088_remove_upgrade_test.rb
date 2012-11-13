class RemoveUpgradeTest < ActiveRecord::Migration
  def up
    Test.where(:name => "upgrade").destroy_all
  end

  def down
    platforms = %w{
      ubuntu-1004-32
      ubuntu-1004-64
      ubuntu-1104-64
      ubuntu-1204-64
      fedora-15-64
      fedora-17-64
      centos-5-64
      centos-6-64
      solaris-10u9-64
      freebsd-9-64
      smartos-64
      osx-64
    }
    projects = Project.where(:name => %w{riak riak_ee}).all
    platforms.each do |p|
      test = Test.create(:name => "upgrade", :tags => {'platform' => p})
      projects.each do |project|
        project.tests << test
      end
    end
  end
end
