class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.datetime :last_check_at

      t.timestamps
    end
  end
end
