# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.275 / @SHA_*@ placeholders below with
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
  version "0.9.275"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.275/stella-0.9.275-aarch64-apple-darwin.tar.gz"
      sha256 "23342653c35d403ed6caa953592ef0b94fb18eb5408755457088bb135c6243cc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.275/stella-0.9.275-x86_64-apple-darwin.tar.gz"
      sha256 "594d8479905706afb03c9842a86c7c0d2f29e95b5ae49a37d5a931564b93cedf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.275/stella-0.9.275-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "393fdeb9d510350cd1ce18d04197ed21d8b38e69bd9e68dfa5d9325daa06af9c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.275/stella-0.9.275-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "972d13d8bd1ed5692d2fbc76451cb37b77c22f25d5e0d7f8b97282232ef0affb"
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
