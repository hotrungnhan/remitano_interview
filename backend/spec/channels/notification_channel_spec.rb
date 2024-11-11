# # frozen_string_literal: true

# RSpec.describe NotificationChannel do
#   let(:user) { create(:user) }

#   before do
#     stub_connection current_user: user
#   end

#   context 'when subcribe' do
#     before do
#       subscribe
#     end

#     it do
#       expect(subscription).to be_confirmed
#       expect(subscription).to have_stream_from('notification_global')
#     end
#   end

#   context 'when unsubcribed' do
#     before do
#       subscribe
#       unsubscribe
#     end

#     it do
#       expect(subscription).not_to have_streams
#     end
#   end
# end
