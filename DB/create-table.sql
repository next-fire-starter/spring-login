---------------------------------------------------------------------------------------------postgresql
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

ALTER TABLE users ADD CONSTRAINT UKEY_user_email UNIQ(email);

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

ALTER TABLE user_profile ADD CONSTRAINT FOREIGN KEY FKEY_user_profile_id_user_id (user_id) REFERENCES user (id);

COMMENT ON TABLE user_profile IS 'ユーザプロフィール';
COMMENT ON COLUMN user_profile.user_id IS 'ユーザID';
COMMENT ON COLUMN user_profile.nick_name IS 'ニックネーム';
COMMENT ON COLUMN user_profile.avatar_image IS 'アバター';
COMMENT ON COLUMN user_profile.create_at IS '作成日';
COMMENT ON COLUMN user_profile.update_at IS '更新日';

---------------------------------------------------------------------------------------------mysql
DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id BIGINT AUTO_INCREMENT                    COMMENT 'ユーザーID',
  name VARCHAR(60) NOT NULL                   COMMENT 'ユーザー名',
  email VARCHAR(120) NOT NULL                 COMMENT 'メールアドレス',
  password VARCHAR(255) NOT NULL              COMMENT 'パスワード',
  roles VARCHAR(120)                          COMMENT 'ロール',
  lock_flag BOOLEAN NOT NULL DEFAULT 0        COMMENT 'ロックフラグ 1:ロック',
  disable_flag BOOLEAN NOT NULL DEFAULT 0     COMMENT '無効フラグ 1:無効',
  create_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  update_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (id)
)
ENGINE = INNODB
DEFAULT CHARSET = UTF8MB4
COMMENT = 'ユーザーテーブル';

ALTER TABLE user ADD CONSTRAINT UNIQUE KEY UKEY_user_email (email);


DROP TABLE IF EXISTS user_profile;
CREATE TABLE user_profile (
  id BIGINT AUTO_INCREMENT                    COMMENT 'ユーザープロフィールID',
  user_id BIGINT NOT NULL                     COMMENT 'ユーザーID',
  nick_name VARCHAR(60)                       COMMENT 'ニックネーム',
  avatar_image MEDIUMBLOB                     COMMENT 'アバターイメージ',
  create_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  update_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (id)
)
ENGINE = INNODB
DEFAULT CHARSET = UTF8MB4
COMMENT = 'ユーザープロフィールテーブル';

ALTER TABLE user_profile ADD CONSTRAINT FOREIGN KEY FKEY_user_profile_id_user_id (user_id) REFERENCES user (id);
