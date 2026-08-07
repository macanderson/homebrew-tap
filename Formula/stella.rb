# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.130 / @SHA_*@ placeholders below with
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
  version "0.6.130"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.130/stella-0.6.130-aarch64-apple-darwin.tar.gz"
      sha256 "caec671f31cbff10e1584611281ed3a1e0085fd164ef0070cfd154121f2c9a6a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.130/stella-0.6.130-x86_64-apple-darwin.tar.gz"
      sha256 "b085f4354356bb56d441690c8d2419887dadc9c6acb305b20726a9aa69fb5e59"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.130/stella-0.6.130-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1c28bb2e3c731b38eee2fd04d83bf9e61c38493c97dd44776885516ded802f18"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.130/stella-0.6.130-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9c9ed669a414b7543e81524fa8a436ecb977542395c107f7e58d9c900591e476"
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
