class Translation < ApplicationRecord
  belongs_to :source_lang, class_name: 'Translations::Language'
  belongs_to :target_lang, class_name: 'Translations::Language'
  belongs_to :requester, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :status, class_name: 'Translations::Status', optional: true
  belongs_to :priority, class_name: 'Translations::Priority'
  has_many :broadcast_items, class_name: 'Broadcast::Item', foreign_key: 'request_id'

  after_create do
    unless status.present?
      update status: Translations::Status['Pending Assessment']
    end
  end
end