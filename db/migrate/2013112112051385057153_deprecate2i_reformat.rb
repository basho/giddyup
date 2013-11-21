class Deprecate2iReformat < ActiveRecord::Migration
  def up
    Test.where(name: 'verify_secondary_index_reformat').each do |t|
      if t.tags['max_version'].nil? || t.tags['max_version'] > '1.4.99'
        t.tags['max_version'] = '1.4.99'
      end
      t.save!
    end
  end

  def down
    Test.tagged('max_version' => '1.4.99').where(name: 'verify_secondary_index_reformat').each do |t|
      t.tags.delete 'max_version'
      t.save!
    end
  end
end
