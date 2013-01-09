class AddVersionToCapabilities < ActiveRecord::Migration
  def up
    say_with_time "adding upgrade_version to rolling_capabilities" do
      @projects = Project.where(:name => %w{riak riak_ee}).all
      %w{rolling_capabilities}.each do |name|
        Test.where(:name => name).each do |test|
          unless test.tags['upgrade_version']
            test.tags['upgrade_version'] = 'previous'
            test.save!
            create_riak_test name, test.tags.dup.merge('upgrade_version' => 'legacy') unless test.tags['platform'] =~ /freebsd/
          end
        end
      end
    end
  end

  def down
    say_with_time 'Removing upgrade_version tags from rolling_capabilities tests' do
      %w{rolling_capabilities}.each do |name|
        Test.where(:name => name).each do |test|
          if test.tags['upgrade_version'] == 'legacy'
            test.destroy!
          else
            test.tags.delete('upgrade_version')
            test.save!
          end
        end
      end
    end
  end

  def create_riak_test(name, tags)
    unless Test.where(:name => name).where(['tests.tags::hstore @> ?', HstoreSerializer.dump(tags) ]).exists?
      if tags['platform'] =~ /fedora-15/
        tags['max_version'] = '1.2.99'
      end
      test = Test.create!(:name => name, :tags => tags)
      @projects.each {|p| p.tests << test }
    end
  end
end
