# spec/support/files_test_helper.rb
module FilesTestHelper
  extend self
  extend ActionDispatch::TestProcess

  def dummy_image(index = 0)
    file_path = Dir.glob(Rails.root.join('spec', 'support', 'assets', 'dummy_images', '**', '*')).sort[index]
    upload(file_path, 'image/png')
  end

  def image_signed_id(index = 0)
    file_path = Dir.glob(Rails.root.join('spec', 'support', 'assets', 'dummy_images', '**', '*')).sort[index]
    ActiveStorage::Blob.create_and_upload!(
      io: File.open(file_path, 'rb'),
      filename: file_path,
      content_type: 'image/png'
    ).signed_id
  end

  private

  def upload(file_path, type)
    Rack::Test::UploadedFile.new(file_path, type)
  end
end
