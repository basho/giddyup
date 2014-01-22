class ReplReduced21 < ActiveRecord::Migration
  def up
    say_with_time "Moving repl_reduced test to riak_ee 2.1" do
      Test.where(name: 'repl_reduced').each do |t|
        t.tags['min_version'] = '2.1.0'
        t.save!
      end
    end
  end

  def down
    raise 'irreversible'
  end
end
