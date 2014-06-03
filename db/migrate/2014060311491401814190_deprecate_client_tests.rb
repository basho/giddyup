class DeprecateClientTests < ActiveRecord::Migration
  def up
    Test.where(name: %w{client_java_verify
                        client_ruby_verify
                        client_python_verify}).each do |t|
      t.tags['max_version'] ||= '1.4.99'
      t.save!
    end
  end

  def down
    Test.where(name: %w{client_java_verify
                        client_ruby_verify
                        client_python_verify}).each do |t|
      if t.tags['max_version'] == '1.4.99'
        t.tags.delete 'max_version'
        t.save!
      end
    end
  end
end
