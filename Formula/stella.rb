# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.105 / @SHA_*@ placeholders below with
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
  version "0.9.105"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.105/stella-0.9.105-aarch64-apple-darwin.tar.gz"
      sha256 "ac388beadbedb24beb404dce2c4a8e7592a1f9a020621a594922b27c533228c2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.105/stella-0.9.105-x86_64-apple-darwin.tar.gz"
      sha256 "750017e418818646818c98112fc8f2093dc69950514ca745db98c4e051401b38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.105/stella-0.9.105-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e22882e691f7a2f33f33b52fc936a617d2af307fefc90b73ad74eec70de5ac1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.105/stella-0.9.105-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6f056da3867ce7b5844fa5798028f6a00b84613819f3740d433143462d115b64"
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
