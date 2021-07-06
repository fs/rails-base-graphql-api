Rails.application.config.after_initialize do
  Bullet.enable = true
  Bullet.bullet_logger = true
end
