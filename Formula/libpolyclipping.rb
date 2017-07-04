# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libpolyclipping < Formula
  desc "An open source freeware library for clipping and offsetting lines and polygons."
  homepage "http://www.angusj.com/delphi/clipper.php"
  url "https://downloads.sourceforge.net/project/polyclipping/clipper_ver6.4.2.zip"
  sha256 "a14320d82194807c4480ce59c98aa71cd4175a5156645c4e2b3edd330b930627"

  depends_on "cmake" => :build

  def install
    cd "cpp" do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args
        system "make"
      end
      lib.install Dir["build/*.dylib"]
      include.install "clipper.hpp"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test polyclipper`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
