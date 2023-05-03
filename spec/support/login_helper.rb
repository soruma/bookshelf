# frozen_string_literal: true

module LoginHelper
  def login_as(user)
    cognito_session = create(:cognito_session, user:)

    session = { cognito_session_id: cognito_session.id }
    session.class_eval { def enabled? = true }
    session.class_eval { def loaded? = true }

    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(session)
  end
end
