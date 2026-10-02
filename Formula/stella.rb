# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.465 / @SHA_*@ placeholders below with
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
  version "0.9.465"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.465/stella-0.9.465-aarch64-apple-darwin.tar.gz"
      sha256 "f388188945168e9b6feb8fc376b3d3865f3053169f1061753165caf49bbad00c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.465/stella-0.9.465-x86_64-apple-darwin.tar.gz"
      sha256 "a44362562281af7fcb63a8823e4ed8b842dab9fa8a326ba20ed1802093815239"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.465/stella-0.9.465-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f591d02a470ff133353be2e294dcd021a02c9e40e20812f744877006f3c764d8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.465/stella-0.9.465-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50dbfd90891c61f61fc2f3bb7ccdde5a02c1d127f6c0a84f9e355b57c38b6c33"
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
