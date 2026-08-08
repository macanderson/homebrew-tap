# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.16 / @SHA_*@ placeholders below with
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
  version "0.7.16"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.16/stella-0.7.16-aarch64-apple-darwin.tar.gz"
      sha256 "0238eed1ff806d9a028033db02d193743a3c9154dc394550bdc3e93c027b46bc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.16/stella-0.7.16-x86_64-apple-darwin.tar.gz"
      sha256 "4c0b7099b9b0c88483129771605b4cd04b34fd5f3bfd3c07827e17ab3886a99b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.16/stella-0.7.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "be9ce5fbf41471f3062515abd0b35ed9d4e407514c8f6aa977d76502c1be76bb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.16/stella-0.7.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b343d37a34c02f69cdab0a282faa76aa9dc3a44f177241b60676716d2062295e"
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
