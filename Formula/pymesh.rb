# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Pymesh < Formula
  desc "PyMesh is a rapid prototyping platform focused on geometry processing."
  homepage "http://pymesh.readthedocs.org/en/latest/"
  url "https://github.com/qnzhou/PyMesh.git"
  version "0.10"
  sha256 ""

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "boost"
  depends_on "eigen"
  depends_on :python3 => ["numpy", "scipy"]
  depends_on "google-sparsehash" => :recommended
  depends_on "cgal@4.10" => ["with-eigen", :recommended]
  depends_on "tetgen" => :recommended
  depends_on "libigl" => :recommended
  depends_on "cork" => :recommended
  depends_on "triangle" => :recommended
  depends_on "qhull" => :recommended
  depends_on "libclipper" => :recommended
  depends_on "carve" => :recommended

  def install
      # do the actual install.
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test pymesh`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
