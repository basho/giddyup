class RemoveReplRtAck < ActiveRecord::Migration
  def up
    say_with_time "Removing repl_rt_ack test" do
      Test.where(name: 'repl_rt_ack').destroy_all
    end
  end

  def down
    raise 'irreversible'
  end
end
