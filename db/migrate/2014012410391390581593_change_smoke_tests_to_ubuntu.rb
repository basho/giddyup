class ChangeSmokeTestsToUbuntu < ActiveRecord::Migration
  def up
    say_with_time "Changing smoke-tests platform to ubuntu 12" do
      Project.find_by_name('smoke-tests').tests.each do |t|
        t.tags['platform'] = 'ubuntu-1204-64'
        t.save!
        print '.'
      end
    end
  end

  def down
    say_with_time "Changing smoke-tests platform to centos 6" do
      Project.find_by_name('smoke-tests').tests.each do |t|
        t.tags['platform'] = 'centos-6-64'
        t.save!
        print '.'
      end
    end
  end
end
