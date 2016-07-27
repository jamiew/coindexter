Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'OzjRXl3kCGXuWsfg9u9GkdKd2gkJPRjB',
    'nJe1utpwpsJZCuVVuhBST9aQCr51KiU_4rbMNmeekcRMfZSp-XJLuTBnZvIMg_nJ',
    'libvoness.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end