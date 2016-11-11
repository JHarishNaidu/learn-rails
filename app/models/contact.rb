class Contact < ActiveRecord::Base 
include ActiveModel::Model
require "csv"

attr_accessor :name
attr_accessor :email
attr_accessor :content
has_no_table

#column :name, :string
#column :email, :string
#column :content, :string

validates_presence_of :name
validates_presence_of :email
validates_presence_of :content
validates_format_of :email,
:with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
validates_length_of :content, :maximum => 500
def update_spreadsheet
headers=["Time","Name","Email","Content"]
File.open('/home/harishnaidu/Desktop/app_user_detailes.csv', 'a'){ |outfile|
   CSV.open(outfile,'ab') do |csv|
    logger.info"#{csv}"
    csv << ["#{Time.now}","#{self.name}","#{self.email}","#{self.content}"]    
   end
}
end


=begin
credentials = Google::Auth::UserRefreshCredentials.new(
  client_id: "483426567417-9vpcq7md0td5intvbu3gneh386rok538.apps.googleusercontent.com",
  client_secret: "q8onCMgB-E-5wDIU4TjidjYu",
  scope: [
    "https://www.googleapis.com/auth/drive",
    "https://spreadsheets.google.com/feeds/",
  ],
  redirect_uri: "http://localhost:3000/contacts/new")
auth_url = credentials.authorization_uri
# Redirect the user to auth_url and get authorization code from redirect URL.
credentials.code = authorization_code
credentials.fetch_access_token!
session = GoogleDrive.login_with_oauth(credentials)
ss = session.spreadsheet_by_title('Learn-Rails-Example')
if ss.nil?
ss = session.create_spreadsheet('Learn-Rails-Example')
end
ws = ss.worksheets[0]
last_row = 1 + ws.num_rows
ws[last_row, 1] = Time.new
ws[last_row, 2] = self.name
ws[last_row, 3] = self.email
ws[last_row, 4] = self.content
ws.save
=end

=begin
def update_spreadsheet
session = GoogleDrive::Session.from_config("config.json")
#connection = GoogleDrive.login_with_oauth(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"])
ss = session.spreadsheet_by_title('Learn-Rails-Example')
if ss.nil?
ss = session.create_spreadsheet('Learn-Rails-Example')
end
ws = ss.worksheets[0]
last_row = 1 + ws.num_rows
ws[last_row, 1] = Time.new
ws[last_row, 2] = self.name
ws[last_row, 3] = self.email
ws[last_row, 4] = self.content
ws.save
end
=end
end
