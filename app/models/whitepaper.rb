class Whitepaper < ApplicationRecord
	mount_uploader :whitepaper, WhitepaperUploader
	belongs_to :network
end
