# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.210 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.210"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.210/stella-0.9.210-aarch64-apple-darwin.tar.gz"
      sha256 "8f1d308157851ee4d88629e333bc37d93239c6e509bcb773ac84fc96d52ca68a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.210/stella-0.9.210-x86_64-apple-darwin.tar.gz"
      sha256 "eb3561e48901c8004fd16364d509ae87be1a9eb4e32d177ed2464bc64ab20e0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.210/stella-0.9.210-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a51677f0c47545f3ed69aaf1e3f1d54ec1e56d0c4a6794d9843c53d4064641e1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.210/stella-0.9.210-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c133664deb4df712c88ea5dd2a225a9f7dd4bfced8c83029e92c75cef582395d"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
