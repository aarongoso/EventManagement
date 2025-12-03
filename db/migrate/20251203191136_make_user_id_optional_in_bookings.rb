class MakeUserIdOptionalInBookings < ActiveRecord::Migration[7.1]
  def change
    # updating null constraint after removing auth
    change_column_null :bookings, :user_id, true
  end
end
