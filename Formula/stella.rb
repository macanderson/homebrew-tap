# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.405 / @SHA_*@ placeholders below with
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
  version "0.9.405"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.405/stella-0.9.405-aarch64-apple-darwin.tar.gz"
      sha256 "89b10137a6d4bba84b1eb976944c9f7035ca0e755ea60f8d193709f355312e68"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.405/stella-0.9.405-x86_64-apple-darwin.tar.gz"
      sha256 "4b1454f5262fd87b70ba305a0f63c412defa56cc8d4c9134585eea820c6bad14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.405/stella-0.9.405-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a653017693379f866bdfd86e1ff8aacf857dfd44b4876516a8988d7617f1a18"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.405/stella-0.9.405-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "51638597c7a6a950d9a7ef92a35f7751ad0c10c2287a5addad9855bec44b1e21"
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
