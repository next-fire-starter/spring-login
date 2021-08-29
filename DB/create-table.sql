----------------------------------------------------------------users
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id serial,
  name VARCHAR(60) NOT NULL,
  email VARCHAR(120) NOT NULL,
  password VARCHAR(120) NOT NULL,
  roles VARCHAR(120),
  lock_flag BOOLEAN NOT NULL DEFAULT FALSE,
  disable_flag BOOLEAN NOT NULL DEFAULT FALSE,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

ALTER TABLE users ADD CONSTRAINT ukey_user_email UNIQUE(email);

COMMENT ON TABLE users IS 'ユーザ';
COMMENT ON COLUMN users.id IS 'ユーザID';
COMMENT ON COLUMN users.name IS 'ユーザー名';
COMMENT ON COLUMN users.email IS 'メールアドレス';
COMMENT ON COLUMN users.password IS 'パスワード';
COMMENT ON COLUMN users.roles IS 'ロール';
COMMENT ON COLUMN users.lock_flag IS 'ロックフラグ TRUE:ロック';
COMMENT ON COLUMN users.disable_flag IS '無効フラグ TRUE:無効';
COMMENT ON COLUMN users.create_at IS '作成日';
COMMENT ON COLUMN users.update_at IS '更新日';

-- テーブル確認コマンド \dt+
-- テーブルカラム確認コマンド \d+ users

----------------------------------------------------------------user_profile

DROP TABLE IF EXISTS user_profile;
CREATE TABLE IF NOT EXISTS user_profile (
  id serial,
  user_id BIGINT NOT NULL,
  nick_name VARCHAR(60),
  avatar_image BYTEA,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

ALTER TABLE user_profile ADD CONSTRAINT fkey_user_profile_id_user_id FOREIGN KEY (user_id) REFERENCES users (id);

COMMENT ON TABLE user_profile IS 'ユーザプロフィール';
COMMENT ON COLUMN user_profile.id IS 'ユーザプロフィールID';
COMMENT ON COLUMN user_profile.user_id IS 'ユーザID';
COMMENT ON COLUMN user_profile.nick_name IS 'ニックネーム';
COMMENT ON COLUMN user_profile.avatar_image IS 'アバター';
COMMENT ON COLUMN user_profile.create_at IS '作成日';
COMMENT ON COLUMN user_profile.update_at IS '更新日';
