class Lead < ActiveRecord::Base
  attr_accessible :feed_id, :job_hash, :link, :posted_at, :source, :title
end
