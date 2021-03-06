require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC4.tgz"
  sha256 "ee50e0d7eb83eb73827f7c34bd3ab80ae167d51f828bc2692d379555b70f8edf"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "a8d3816a7a0457a4a9f111aba2c9be78e03920201f0285729a449aad6e2341ff" => :sierra
    sha256 "67ff67fb49026a7ed0400c9f58eae7ddff1365a5feb97559dad0806f3519313a" => :el_capitan
    sha256 "581229db2fa2539882b1a265d83d504b36a68db10fd352c0e0b741eb7551bc45" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
