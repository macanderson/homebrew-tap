# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.2 / @SHA_*@ placeholders below with
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
  version "0.8.2"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.2/stella-0.8.2-aarch64-apple-darwin.tar.gz"
      sha256 "ad3cd8a63acf758f2c77e996f98a08477b258a71452571426261cebf47db5e23"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.2/stella-0.8.2-x86_64-apple-darwin.tar.gz"
      sha256 "84bad00c5c92c2d962f9d34d179af6528c44c5083dd7eb0049c7db07aaf125ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.2/stella-0.8.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ad7e96f267f3cd591551f529b72a1c957ac73fed3cb0ae5f52895e5fb2b6a52"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.2/stella-0.8.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dcff9f7e256304e81f423f96f2eb5fa3550e59359a3c60616358e979c105c2bb"
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
