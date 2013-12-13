class Fix2iAaeBackends < ActiveRecord::Migration
  def up
      say_with_time 'Adding correct backends for verify_2i_aae' do
          @projects = Project.where(:name => %w{riak riak_ee}).all
          name = 'verify_2i_aae'
          Test.where(name: name).each do |t|
              backend = t.tags['backend']
              unless t.tags['backend']
                  %w{eleveldb memory multi}.each do |b|
                      nt = Test.create!(:name => name,
                                        :tags => t.tags.dup.merge('backend' => b))

                      @projects.each {|p| p.tests << nt }
                  end
                  t.destroy
              end
          end
      end
  end

  def down
  end
end
