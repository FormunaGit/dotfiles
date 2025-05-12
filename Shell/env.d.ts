declare const SRC: string

declare module "inline:*" {
    const content: string
    export default content
}

declare module "*.scss" {
    const content: string
    export default content
}

declare module "*.blp" {
    const content: string
    export default content
}

declare module "*.css" {
    const content: string
    export default content
}

declare namespace JSX {
  interface IntrinsicElements {
    box: any;
    window: any;
    Divider: any;
    label: any;
    eventbox: any;
    icon: any;
    button: any;
    entry: any;
    revealer: any;
    // Add other Astal components here
  }
} 
