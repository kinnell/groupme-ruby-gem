# frozen_string_literal: true

RSpec.describe GroupMe::ImageClient do
  include_context :with_default_groupme_configuration

  let(:image_blob) { '\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\b\x03\x00\x00\x00(\xCB4\xBB\x00\x00\x00\x03PLTE\xDD.DX\x9D\x17\x1C\x00\x00\x00\x01tRNS\xD8\xC8\xEE\x82\x80\x00\x00\x00\nIDATx\x01c`\x00\x00\x00\x02\x00\x01su\x01\x18\x00\x00\x00\x00IEND\xAEB`\x82' }

  describe '#new' do
    it 'should send the correct HTTP request' do
      _image_client = GroupMe::ImageClient.new
      _image_client.upload(image_blob)

      expect(WebMock).to have_requested(:post, 'https://image.groupme.com/pictures').with(body: image_blob.to_json)
    end
  end
end
