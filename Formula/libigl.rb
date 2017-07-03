# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libigl < Formula
  desc "libigl is a simple C++ geometry processing library. This is the header-only version."
  homepage ""
  version "1.2.1"
  url "https://github.com/libigl/libigl.git" 
    :revision => "30aff4877166881ddcc3a7fc559ca62377d2b63e", 
  end 

  head "https://github.com/libigl/libigl.git"

  depends_on "eigen"

  def install
      include.install Dir["include/*"]
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libigl`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
