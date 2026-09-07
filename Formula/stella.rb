# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.398 / @SHA_*@ placeholders below with
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
  version "0.9.398"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.398/stella-0.9.398-aarch64-apple-darwin.tar.gz"
      sha256 "e3e29d271177ef746a1bfe34c33e5b7b16ce7a3b2198aa3aeee15d832ba92d7d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.398/stella-0.9.398-x86_64-apple-darwin.tar.gz"
      sha256 "8e824e0f63eb514259a6b9f9b1bf23b28cefd857377d156c946b304d3ca1d16b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.398/stella-0.9.398-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f8df29a9482c4978038b203c771748f7c08aaa64c19c72e80a237098862b5c75"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.398/stella-0.9.398-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ab176c3d82600e602e7289a0a301e22dd71284335069b64624fcda20f85be0f"
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
