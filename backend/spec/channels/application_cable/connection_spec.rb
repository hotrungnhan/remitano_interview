# # frozen_string_literal: true

# RSpec.describe ApplicationCable::Connection do
#   include_context 'with authenticated headers and user'
#   let(:uri) { '/cable' }

#   context 'when successfully connect' do
#     it do
#       connect %(/cable?auth_token=#{authenticated_headers['Authorization']})
#       expect(connection.current_user.id).to eq authenticated_user.id
#     end
#   end

#   context 'when reject connects' do
#     it do
#       expect { connect '/cable' }.to have_rejected_connection
#     end
#   end
# end
