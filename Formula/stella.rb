# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.23 / @SHA_*@ placeholders below with
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
  version "0.6.23"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.23/stella-0.6.23-aarch64-apple-darwin.tar.gz"
      sha256 "785ddf4cd3f8e278f591325b061510256a553a514e482f482ff60a340e3eaee3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.23/stella-0.6.23-x86_64-apple-darwin.tar.gz"
      sha256 "7f4057c5f4cc5fcba41b3058dbb4908a930646aa0e31e985bd994e7b0a3c1083"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.23/stella-0.6.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0415b791e73099169bde48f291bba7cbeaa11d4dd2e06cb767c4704d9d53d3e5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.23/stella-0.6.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ede6df06eacb6a463972a555d62e81b5582432be267da166fb56efcd7ae6b0f"
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
