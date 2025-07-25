class Entry < ApplicationRecord
  belongs_to :journal
  has_rich_text :content
end
