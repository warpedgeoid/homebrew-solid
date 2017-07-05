# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libigl < Formula
  desc "libigl is a simple C++ geometry processing library."
  homepage "http://libigl.github.io/libigl/"
  url "https://github.com/libigl/libigl.git", :revision => "3abd9ae411cb642b8f3cd7c925acb4dbfedc7ff9"
  version "1.2.1"  
  head "https://github.com/libigl/libigl.git"

  depends_on "eigen"

  def install
      include.install Dir["include/*"]
  end

  test do
    #include <igl/cotmatrix.h>
    # #include <Eigen/Dense>
    # #include <Eigen/Sparse>
    # #include <iostream>
    # int main()
    # {
    #   Eigen::MatrixXd V(4,2);
    #   V<<0,0,
    #      1,0,
    #      1,1,
    #      0,1;
    #   Eigen::MatrixXi F(2,3);
    #   F<<0,1,2,
    #      0,2,3;
    #   Eigen::SparseMatrix<double> L;
    #   igl::cotmatrix(V,F,L);
    #   std::cout<<"Hello, mesh: "<<std::endl<<L*V<<std::endl;
    #   return 0;
    # }
    system "false"
  end
end
